class DiagramsController < ApplicationController
  before_action :set_diagram, only: [:show, :edit, :update, :destroy, :share]
  before_action :set_diagrams_id, only: [:new]
  before_action :require_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /diagrams
  # GET /diagrams.json
  def index
    @diagrams = Diagram.all
  end

  # GET /diagrams/1
  # GET /diagrams/1.json
  def show
    gon.push({ :diagram_image => @diagram.image })
  end

  # GET /diagrams/new
  def new
    @diagram = Diagram.new
  end

  # GET /diagrams/1/edit
  def edit
  end

  # POST /diagrams
  # POST /diagrams.json
  def create
    @diagram =  (User.find_by espol: current_user).diagrams.create(diagram_params)
    #Diagram.new(diagram_params)

    respond_to do |format|
      if @diagram.save
        format.html { redirect_to window_path, notice: 'Diagram was successfully created.' }
        format.json { render :show, status: :created, location: @diagram }
      else
        format.html { render :new }
        format.json { render json: @diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diagrams/1
  # PATCH/PUT /diagrams/1.json
  def update
    respond_to do |format|
      if @diagram.update(diagram_params)
        format.html { redirect_to @diagram, notice: 'Diagram was successfully updated.' }
        format.json { render :show, status: :ok, location: @diagram }
      else
        format.html { render :edit }
        format.json { render json: @diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagrams/1
  # DELETE /diagrams/1.json
  def destroy
    @diagram.destroy
    respond_to do |format|
      format.html { redirect_to window_path, notice: 'Diagram was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def share
    DiagramsUser.create(diagram_id: @diagram.id, user_id: (User.find_by espol: params[:share_user]).id, shared: true)
    respond_to do |format|
      format.html { }
      format.json {head :no_content}
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_diagram
    @diagram = Diagram.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def diagram_params
    params.require(:diagram).permit(:name, :image)
  end

  def set_diagrams_id
    @diagrams_id = Diagram.last.id + 1
  end
end
