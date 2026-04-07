class CompaniesController < ApplicationController
  def show
    render json: current_company
  end
end