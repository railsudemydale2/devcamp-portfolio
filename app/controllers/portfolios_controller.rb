class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
  layout 'portfolio'
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all
  
    def index
      @portfolio_items = Portfolio.by_position
    end

    def angular
        @angular_portfolio_items = Portfolio.angular
    end
  
    def new
      @portfolio_item = Portfolio.new
      3.times { @portfolio_item.technologies.build }
    end
  
    def create
      @portfolio_item = Portfolio.new(portfolio_params)
  
      respond_to do |format|
        if @portfolio_item.save
          format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.' }
        else
          format.html { render :new }
        end
      end
    end

    def edit 
        # @portfolio_item = Portfolio.find(params[:id])
    end

    def update
        # @portfolio_item = Portfolio.find(params[:id])

        respond_to do |format|
          if @portfolio_item.update(portfolio_params)
            format.html { redirect_to portfolios_path, notice: "The record was successfully updated." }
            
          else
            format.html { render :edit, status: :unprocessable_entity }
            
          end
        end
      end

      def show
        
        # @portfolio_item = Portfolio.find(params[:id])
      end

      def destroy
        # Perform the lookup
        # @portfolio_item = Portfolio.find(params[:id])

        # Destroy/delete the record
        @portfolio_item.destroy
        
        # Redirect
        respond_to do |format|
          format.html { redirect_to portfolios_url, notice: "Record was successfully removed!" }
          format.json { head :no_content }
        end
      end

      private
        def portfolio_params
          params.require(:portfolio).permit(:title, 
                                           :subtitle,
                                           :body,
                                           technologies_attributes: [:name]
                                          )
        end

        def set_portfolio_item
          @portfolio_item = Portfolio.find(params[:id])
        end

  
  end
  