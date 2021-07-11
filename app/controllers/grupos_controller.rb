class GruposController < ApplicationController
    before_action :set_grupo, only: [:show, :update, :destroy]
  
    # GET /grupos
    def index
      @grupos = Grupo.all
      json_response(@grupos)
    end
  
    # POST /grupos
    def create
      @grupo = Grupo.create!(grupo_params)
      json_response(@grupo, :created)
    end
  
    # GET /grupos/:id
    def show
      json_response(@grupo)
    end
  
    # PUT /grupos/:id
    def update
      @grupo.update(grupo_params)
      head :no_content
    end
  
    # DELETE /grupos/:id
    def destroy
      @grupo.destroy
      head :no_content
    end
  
    private
  
    def grupo_params
      # whitelist params
      params.permit(:nome)
    end
  
    def set_grupo
      @grupo = Grupo.find(params[:id])
    end
  end