# frozen_string_literal: true

# Page controller class
class PageController < ApplicationController
  before_action :authenticate_user!, only: [:account]
  
  def home; end

  def doc; end

  def account
    
  end
end
