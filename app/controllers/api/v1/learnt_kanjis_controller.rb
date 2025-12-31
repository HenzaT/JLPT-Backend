# Created API, V1 modules for cleaner url
module Api
  module V1
    class LearntKanjisController < ApplicationController
      def index
        learnt_kanjis = LearntKanji.all
        render json: learnt_kanjis, status: :ok
      end

      def show
        learnt_kanji = LearntKanji.find(params[:id])
        render json: learnt_kanji, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'item not found' }, status: :not_found
      end

      def create
        learnt_kanji = LearntKanji.new(learnt_kanji_params)
        if learnt_kanji.save
          render json: learnt_kanji, status: :created
        else
          render json: { errors: learnt_kanji.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        learnt_kanji = LearntKanji.find(params[:id])
        if learnt_kanji.update(learnt_kanji_params)
          render json: learnt_kanji, status: :ok
        else
          render json: { errors: learnt_kanji.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        learnt_kanji = LearntKanji.find(params[:id])
        learnt_kanji.destroy
      end

      private

      def learnt_kanji_params
        params.require(:learnt_kanji).permit(:user_id, :kanji_character_id, :has_learnt)
      end
    end
  end
end
