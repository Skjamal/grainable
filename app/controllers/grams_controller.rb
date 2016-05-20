class GramsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @grams = Gram.all
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
    return render_not_found(:forbidden) if @gram.user != current_user
  end
   

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user

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
    return render_not_found(:forbidden) if @gram.user != current_user
      @gram.destroy
      redirect_to root_path
   end





  private
  def gram_params
    params.require(:gram).permit(:message, :picture)
  end

  def render_not_found(status=:not_found)
    render text: "#{status.to_s.titleize} :(", status: status
  end

end
