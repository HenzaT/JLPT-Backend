# Created API, V1 modules for cleaner url
module Api
  module V1
    class KanjiCharactersController < ApplicationController
      # /api/v1/kanji_characters || kanji_characters?jlpt=5
      def index
        if params[:jlpt]
          kanjis = KanjiCharacter.where(jlpt: params[:jlpt])
        else
          kanjis = KanjiCharacter.all
        end
        render json: kanjis, status: :ok
      end

      def show
        kanji = KanjiCharacter.find(params[:id])
        render json: kanji, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Kanji not found' }, status: :not_found
      end

      # /api/v1/kanji_characters/counts
      def counts
        render json: KanjiCharacter.group(:jlpt).count, status: :ok
      end

      def random
        if params[:jlpt]
          kanjis = KanjiCharacter.where(jlpt: params[:jlpt])
        else
          kanjis = KanjiCharacter.all
        end
        random_kanji = kanjis.sample
        render json: random_kanji, status: :ok
      end

      def get_ten
        if params[:jlpt]
          kanjis = KanjiCharacter.where(jlpt: params[:jlpt])
        else
          kanjis = KanjiCharacter.all
        end
        ten_kanjis = kanjis.sample(10)
        render json: ten_kanjis, status: :ok
      end
    end
  end
end
