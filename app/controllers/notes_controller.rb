class NotesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_error

  include Pagy::Backend

  def index
    @pagy, @notes = pagy(
      Note.preload(:taggings).includes(:tags).all,  items: 9, page: params[:page])
  end

  def new
    @note = NoteDecorator.new(Note.new)
  end

  def create
    @note = Note.new(create_params)
    if @note.save
      redirect_to notes_path
    else
      render :new
    end
  end

  def show
    @note = NoteDecorator.new(Note.find(params[:id]))
  end

  private

  def create_params
    params.require(:note).permit(:title, :tag_list, :body)
  end

  def render_error
    redirect_to notes_path, flash: {error: "Record not found."}
  end
end
