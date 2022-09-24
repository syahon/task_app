require 'rails_helper'

RSpec.describe "Post", type: :system do
  let!(:post) { create(:post) }

  describe "スケジュール登録" do
    context "有効なデータを入力した場合" do
      it "登録が成功すること" do
        visit new_post_path

        fill_in "タイトル", with: "Hello World"
        fill_in "開始日", with: "2022/1/1"
        fill_in "終了日", with: "2022/1/2"
        uncheck "終日"

        click_on "新規登録"
        posts = Post.all
        expect(posts.size).to eq 2
        expect(current_path).to eq posts_path

        expect(page).to have_content "スケジュールを登録しました"

        within ".schedule" do
          expect(page).to have_content "Hello World"
        end
      end
    end

    context "無効なデータを入力した場合" do
      it "登録が失敗し入力情報が保持されること" do
        visit new_post_path

        fill_in "開始日", with: "2022/1/2"
        fill_in "終了日", with: "2022/1/1"

        click_on "新規登録"

        expect(page).to have_content "スケジュールを登録できませんでした"
        expect(page).to have_field "開始日", with: "2022-01-02"
        expect(page).to have_field "終了日", with: "2022-01-01"
      end
    end
  end

  describe "スケジュールの編集" do
    it "編集内容が反映されること" do
      visit edit_post_path(post)

      fill_in "タイトル", with: "編集済み"
      fill_in "開始日", with: "2023/1/1"
      fill_in "終了日", with: "2023/1/2"
      check "終日"
      fill_in "スケジュールメモ", with: "メモを更新"

      click_on "編集完了"
      expect(current_path).to eq posts_path

      expect(page).to have_content "スケジュールを編集しました"

      within ".schedule" do
        expect(page).to have_content "編集済み"
        expect(page).to have_content "2023年1月1日"
        expect(page).to have_content "2023年1月2日"
        expect(page).to have_content "○"
      end

      visit post_path(post)
      expect(page).to have_content "メモを更新"
    end
  end

  describe "終日の表示" do
    context "all_dayの値がfalseの場合" do
      it "終日の項目には何も表示されないこと" do
        visit posts_path

        within ".schedule" do
          expect(page).to_not have_content "○"
        end
      end
    end

    context "all_dayの値がtrueの場合" do
      it "終日の項目に○が表示されること" do
        post.update_attribute(:all_day, true)

        visit posts_path

        within ".schedule" do
          expect(page).to have_content "○"
        end
      end
    end
  end

  describe "スケジュール削除" do
    it "スケジュールが削除できること" do
      visit posts_path

      click_link "削除", href: post_path(post)
      posts = Post.all
      expect(posts.size).to eq 0
      expect(current_path).to eq posts_path

      expect(page).to have_content "スケジュールを削除しました"
      within ".schedule" do
        expect(page).to_not have_content "確認"
      end
    end
  end
end
