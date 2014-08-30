class LinesController < ApplicationController
  before_action :set_line

  # GET /lines
  # GET /lines.json
  def index
  end

  # GET /lines/1
  # GET /lines/1.json
  def show
  end

  # GET /lines/new
  def new
    @line = Line.new
  end

  # GET /lines/1/edit
  def edit
  end

  # POST /lines
  # POST /lines.json
  def create
    if @section == 'notifications'
      @line = @notification.lines.build(line_params.except(:section))
    elsif params[:section] == 'dues'
      @line = @due.lines.build(line_params.except(:section))
    end

    respond_to do |format|
      if @line.save
        format.html { redirect_to customer_newsletter_bills_path(@customer, @newsletter, section: @section), notice: 'Line was successfully created.' }
        format.json { render action: 'show', status: :created, location: @line }
      else
        format.html { render action: 'new' }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lines/1
  # PATCH/PUT /lines/1.json
  def update
    respond_to do |format|
      if @line.update(line_params)
        format.html { redirect_to customer_newsletter_bills_path(@customer, @newsletter, section: @section), notice: 'Line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lines/1
  # DELETE /lines/1.json
  def destroy
    @line.destroy
    respond_to do |format|
      format.html { redirect_to customer_newsletter_bills_path(@customer, @newsletter, section: params[:section])}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id]) if params[:id]
      @section = params[:section] || (params[:line][:section] if params[:line])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_params
      params[:line].permit!
    end
end
