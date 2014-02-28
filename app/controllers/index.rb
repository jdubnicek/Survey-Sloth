#***************************************************
#***************************************************
##USERS USERS USERS USERS USERS USERS USERS USERS
#***************************************************
#***************************************************
get '/' do
  # Look in app/views/index.erb
  erb :index
end


#-----------------------
get '/sign_up' do
	erb :sign_up
end

post '/sign_up' do
	@user = User.create(params[:user])
	if @user.valid?
		session[:user_id] = @user.id
		session[:user_name] = @user.name
		redirect to '/homepage'
	else
		erb :sign_up
	end
end
#-----------------------


get '/sign_in' do
	erb :sign_in
end

post '/sign_in' do
	@user = User.where(user_name: params[:user][:user_name]).first
	  if @user.authenticate(params[:user][:password])
	    session[:user_id] = @user.id
	    redirect '/homepage'
	  else
	    redirect '/authentication_fail'
	  end
end

#-----------------------

get '/homepage' do
	@user = User.find(session[:user_id])
	@user_surveys = UserSurveys.all(session[:survey][:user_id])
	erb :homepage
end

#-----------------------

get 'view_profile' do
	@user = User.find(session[:user_id])
	erb :view_profile
end


post 'view_profile' do
	erb :view_profile
end

#-----------------------


get '/create_survey' do
	erb :create_survey
end

post '/create_survey' do
	erb :create_survey
end
#-----------------------



get '/logout' do
	session.clear
	redriect '/'
end

#******************************************************
#******************************************************
##SURVEYS SURVEYS SURVEYS SURVEYS SURVEYS SURVEYS 
#******************************************************
#******************************************************

get '/browse_all' do
	@surveys = Survey.all

	erb :browse_all
end

post '/browse_all' do
	erb :browse_all
end
#-----------------------

get '/view_survey' do
	@survey = Survey.find(params[:survey][:id])
	if @survey.user_id == sessions[:user_id]
		erb :view_survey
	else
		erb :take_survey
	end
end

#-----------------------

get '/take_survey' do
	@survey = Survey.find(params[:survey][:id])
	erb :take_survey
end

#-----------------------

get '/edit_survey' do
	@survey = Survey.find(params[:survey][;id])
	erb :edit_survey
end

post '/edit_survey' do
	@survey = Survey.find(params[:survey][;id])
	@survey.title = params[:survey][:title]
  @survey.question = params[:survey][:question]
  @survey.response = params[:survey][:response]
  if survey.update
	  redirect to '/homepage'
	end
