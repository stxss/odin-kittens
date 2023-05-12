class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.json {render json: @kittens }
      format.html
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      redirect_to @kitten, notice: "Kitten created!"
    else
      flash.now[:alert] = "Oops, silly you, check your fields again"
      flash.now[:alert] = @kitten.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      redirect_to root_path
    else
      flash.now[:alert] = "Oops, silly you, check your fields again"
      flash.now[:alert] = @kitten.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.json { render json: @kitten }
      format.html
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy

    redirect_to root_path, status: :see_other, notice: "You deleted the kitten!"
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
