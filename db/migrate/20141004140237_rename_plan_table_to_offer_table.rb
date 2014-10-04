class RenamePlanTableToOfferTable < ActiveRecord::Migration
  def change
    rename_table    :plans, :offers
    remove_column   :offers, :curr_plan
    remove_column   :offers, :recc_plan
    remove_column   :offers, :othr_plan
    remove_column   :offers, :curr_supplier_id
    remove_column   :offers, :recc_supplier_id
    remove_column   :offers, :othr_supplier_id
    add_column      :offers, :curr_plan_id, :integer
    add_column      :offers, :recc_plan_id, :integer
    add_column      :offers, :othr_plan_id, :integer
  end
end
