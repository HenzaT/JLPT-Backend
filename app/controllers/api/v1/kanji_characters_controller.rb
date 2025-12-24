# Created API, V1 modules for cleaner url
module Api
  module V1
    class KanjiCharactersController < ApplicationController
      def index
        kanjis = KanjiCharacter.all
        render json: kanjis, status: :ok
      end

      def show
        kanji = KanjiCharacter.find(params[:id])
        render json: kanji, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Kanji not found' }, status: :not_found
      end
    end
  end
end
