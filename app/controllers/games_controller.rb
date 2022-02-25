require_relative "../presenters/game"
require_relative "../presenters/error"

require_relative "../services/create_game"
require_relative "../services/play_game"

require_relative "../schema_validators/game/create"
require_relative "../schema_validators/game/update"

require 'json-schema'

class GamesController < ApplicationController

  before_action :validate_schema, only: [
    :create,
    :update,
  ]

  before_action :validate_game_presence, only: [
    :show,
    :update,
  ]

  before_action :validate_game_token, only: [
    :update
  ]

  before_action :validate_game_is_playable, only: [
    :update
  ]

  def create
    game = CreateGame.new(
      duration: params[:duration],
      random: params[:random],
      input_board: params[:board],
    ).execute

    render json: Presenters::Game.new(
      game: game
    ).to_json, status: :created
  end

  def show
    render json: Presenters::Game.new(
      game: game,
      additional_fields: true,
    ).to_json
  end

  def update
    valid_word = PlayGame.new(
      game: game,
      word: params[:word],
    ).execute

    if valid_word
      render json: Presenters::Game.new(
        game: game,
        additional_fields: true,
      ).to_json, status: :ok
    else
      render json: Presenters::Error.new(
        message: "Word is not valid",
      ).to_json, status: :bad_request
    end
  end

  private

  def validate_schema
    schema_validator_klass = "SchemaValidators::Game::#{params[:action].camelize}".constantize
    unless schema_validator_klass.new(input: params.permit!.to_hash).valid?
      render json: Presenters::Error.new(
        message: "Invalid input",
      ).to_json, status: :bad_request
    end
  end

  def game
    @game
  end

  def validate_game_presence
    @game = Game.where(id: params[:id]).first
    if game.nil?
      render json: Presenters::Error.new(
        message: "Game doesn't exists",
      ).to_json, status: :not_found
    end
  end

  def validate_game_token
    unless game.valid_token?(params[:token])
      render json: Presenters::Error.new(
        message: "Token is not valid.",
      ).to_json, status: :unauthorized
    end
  end

  def validate_game_is_playable
    unless game.playable?
      render json: Presenters::Error.new(
        message: "Time over.",
      ).to_json, status: :unauthorized
    end
  end
end
