class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  autocomplete  :plan, :curr_plan, :full => true
  autocomplete  :plan, :recc_plan, :full => true
  autocomplete  :plan, :othr_plan, :full => true

  def copy
    Plan.find(params[:id]).copy(params[:identical_plan])
    render nothing: true
  end

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = @newsletter.plans.build(plan_params)
    plan = Plan.find_identical(plan_params)
    identical_plan = plan ? plan.id : 'no'

    respond_to do |format|
      if @plan.save
        format.html { redirect_to customer_newsletter_plans_path(@customer, @newsletter, plan_id: @plan.id, identical_plan: identical_plan), notice: 'Plan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @plan }
      else
        format.html { render action: 'new' }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to customer_newsletter_plans_path(@customer, @newsletter), notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to customer_newsletter_plans_path(@customer, @newsletter), notice: 'Plan was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params[:plan].permit!
    end
end
