class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :has_rights?, only: %i[edit update destroy]
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
    @event = Event.find(params[:id])
    @end_date = @event.start_date + @event.duration.minutes
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events or /events.json
  def create
    @event = Event.new(title: params[:title],
                       description: params[:description],
                       location: params[:location],
                       start_date: DateTime.new(params[:start_date][:year].to_i,
                                                params[:start_date][:month].to_i,
                                                params[:start_date][:day].to_i,
                                                params[:start_date][:hour].to_i,
                                                params[:start_date][:minute].to_i),
                       duration: params[:duration].to_i,
                       price: params[:price])
    @event.user = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        puts @event.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def has_rights?
    @event = Event.find(params[:id])

    if @event.user_id != current_user.id
      redirect_to root_path
      flash[:notice] = 'Page restricted to the event admin'
    end
  end
end
