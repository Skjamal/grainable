class GramsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
  end
  
  def show
    @gram = Gram.find_by_id(params[:id])

    #if @gram.blank?
      #render text: 'Not Found :(', status: :not_found
    
     if !@gram
  #     render :new, status: :unprocessable_entity
  #   end
      return render_not_found if @gram.blank?
     end
  end
  
  def new
    @gram = Gram.new
  end

  def create
    @gram = Gram.create(gram_params.merge(user: current_user))
      if @gram.valid?
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end


  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?

    @gram.update_attributes(gram_params)
    

    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
      @gram.destroy
      redirect_to root_path
   end





  private
  def gram_params
    params.require(:gram).permit(:message)
  end

  def render_not_found
    render text: 'Not Found =(', status: :not_found
  end

end
