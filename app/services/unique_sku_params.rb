# frozen_string_literal: true

class UniqueSkuParams
  class << self
    def call(params)
      new(params).call
    end

    alias normalize call
  end

  def initialize(params)
    @params = params
  end

  def call
    params
      .group_by { |params| params[:sku] }
      .transform_values(&to_summed_quantities_objects_proc)
      .map(&normalize_params_proc)
  end

  private

  attr_reader :params

  def to_summed_quantities_objects_proc
    proc { |array| array.each_with_object({ quantity: 0 }, &sum_quantities_proc) }
  end

  def sum_quantities_proc
    proc { |itr, object|  object[:quantity] = itr[:quantity] + (object[:quantity]) }
  end

  def normalize_params_proc
    proc { |key, value| { sku: key, quantity: value[:quantity] } }
  end
end
