require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "valid" do
    let!(:post) {build(:post)}
    context "全ての入力値が正常な場合" do
      it "データが有効であること" do
        expect(post).to be_valid
      end
    end

    context "タイトルが空の場合" do
      it "データが無効であること" do
        post.title = " "
        expect(post).to_not be_valid
      end
    end

    context "開始日が未設定の場合" do
      it "データが無効であること" do
        post.start_day = nil
        expect(post).to_not be_valid
      end
    end

    context "終了日が未設定の場合" do
      it "データが無効であること" do
        post.end_day = nil
        expect(post).to_not be_valid
      end
    end

    context "終了日が開始日以前の場合" do
      it "データが無効であること" do
        post.start_day = "2023-1-1"
        post.end_day = "2022-12-1"
        expect(post).to_not be_valid
      end
    end
  end
end
