class MarcacaopontosController < ApplicationController
  # GET /marcacaopontos
  # GET /marcacaopontos.xml
  def index
    @marcacaopontos = Marcacaoponto.find(:all,:order=> 'data desc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @marcacaopontos }
    end
  end

  # GET /marcacaopontos/1
  # GET /marcacaopontos/1.xml
  def show
    @marcacaoponto = Marcacaoponto.find(params[:id])

    respond_to do |format|
    	
    	
    	
      format.html # show.html.erb
      format.xml  { render :xml => @marcacaoponto }
    end
  end

  # GET /marcacaopontos/new
  # GET /marcacaopontos/new.xml
  def new
    @marcacaoponto = Marcacaoponto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @marcacaoponto }
    end
  end

  # GET /marcacaopontos/1/edit
  def edit
    @marcacaoponto = Marcacaoponto.find(params[:id])
  end

  # POST /marcacaopontos
  # POST /marcacaopontos.xml
  def create
  	respond_to do |format|
  	  @funcionario = Funcionario.find(params[:marcacaoponto][:funcionario_id])
  	  
  	  @funcionario.marcar_ponto("aowpa")
  	  flash[:notice] = 'Ponto Registrado!'
      format.html { redirect_to(marcacaopontos_path) }
      format.xml  { head :ok }
     end
  end

  # PUT /marcacaopontos/1
  # PUT /marcacaopontos/1.xml
  def update
    @marcacaoponto = Marcacaoponto.find(params[:id])

    respond_to do |format|
      if @marcacaoponto.update_attributes(params[:marcacaoponto])
        flash[:notice] = 'Ponto Atualizado!'
        format.html { redirect_to(@marcacaoponto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @marcacaoponto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /marcacaopontos/1
  # DELETE /marcacaopontos/1.xml
  def destroy
    @marcacaoponto = Marcacaoponto.find(params[:id])
    @marcacaoponto.destroy

    respond_to do |format|
      format.html { redirect_to(marcacaopontos_url) }
      format.xml  { head :ok }
    end
  end
end
