class FuncionariosController < ApplicationController
  # GET /funcionarios
  # GET /funcionarios.xml
  def index
      @funcionarios = Funcionario.find(:all,:order => 'nome')
       respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @funcionarios }
    end
  end

  # GET /funcionarios/1
  # GET /funcionarios/1.xml
  def show
    @funcionario = Funcionario.find(params[:id])
        year = Time.now.year.to_s
        month = Time.now.month.to_s
      if params[:month].nil? and params[:year].nil?
    	params[:year] = year
      	params[:month] = month
      end
        year = params[:year].to_i   
        month = params[:month].to_i   
        first = Date.civil(year, month, 1)   
        last = Date.civil(year, month, -1)   
    	@marcacaopontos = @funcionario.marcacaopontos.find(:all,:conditions => ["(data BETWEEN ? AND ?)", first.to_datetime, last.to_datetime],:order => 'data')
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @funcionario }
    end
  end

  # GET /funcionarios/new
  # GET /funcionarios/new.xml
  def new
    @funcionario = Funcionario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @funcionario }
    end
  end

  # GET /funcionarios/1/edit
  def edit
    @funcionario = Funcionario.find(params[:id])
  end

  # POST /funcionarios
  # POST /funcionarios.xml
  def create
    @funcionario = Funcionario.new(params[:funcionario])

    respond_to do |format|
      if @funcionario.save
        flash[:notice] = 'Funcionario was successfully created.'
        format.html { redirect_to(@funcionario) }
        format.xml  { render :xml => @funcionario, :status => :created, :location => @funcionario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @funcionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /funcionarios/1
  # PUT /funcionarios/1.xml
  def update
    @funcionario = Funcionario.find(params[:id])

    respond_to do |format|
      if @funcionario.update_attributes(params[:funcionario])
        flash[:notice] = 'Funcionario was successfully updated.'
        format.html { redirect_to(@funcionario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @funcionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /funcionarios/1
  # DELETE /funcionarios/1.xml
  def destroy
    @funcionario = Funcionario.find(params[:id])
    @funcionario.destroy

    respond_to do |format|
      format.html { redirect_to(funcionarios_url) }
      format.xml  { head :ok }
    end
  end
end
