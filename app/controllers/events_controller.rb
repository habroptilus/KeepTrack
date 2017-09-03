class EventsController < ApplicationController
    def index
        @money=Money.find(1)
        @events_unrecorded=Event.where(recorded: 0).order("day")
        @events_recorded=Event.where(recorded: true).order(day: :desc)
        @ThisMonth=Time.now.month
        @LastMonth=Time.now.last_month.month
        @ThisMonth_sum=0
        @LastMonth_sum=0
        Event.all.each do |event|
            if event.day.month==@ThisMonth
                @ThisMonth_sum+=event.amount
            elsif event.day.month==@LastMonth
                @LastMonth_sum+=event.amount
            else

            end
        end
    end

    def show
        @event=Event.find(params[:id])
    end

    def edit
        @event=Event.find(params[:id])
    end

    def update
        @event=Event.find(params[:id])
        @event.assign_attributes(params[:event].permit(:title, :amount, :day,:recorded))
        if @event.save
            @money=Money.find(1)
            @events=Event.all
            render :index
        else
            render "new"
        end
    end


    def new
        @event=Event.new
    end

    def create
        @event=Event.new(params[:event].permit(:title, :amount, :day,:recorded))
        if @event.save
            @money=Money.find(1)
            @events=Event.all
            redirect_to  :root,notice: "新しいeventを登録しました"
        else
            render "new"
        end
    end
    def destroy
        @event=Event.find(params[:id])
        @event.destroy
        redirect_to :root,notice: "eventを削除しました"

    end
end
