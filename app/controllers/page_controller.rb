# frozen_string_literal: true

# Page controller class
class PageController < ApplicationController
  include PageHelper
  before_action :authenticate_user!, only: [:account]
  
  def home; end

  def doc; end

  def account; end

  def regenerate_token
    current_user&.generate_token
    current_user&.save
    respond_to :js
  end
end
