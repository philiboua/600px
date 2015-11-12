module ControllerHelpers
  def login_with(user = double('user'), scope = :user)
    current_user = "current_#{scope}".to_sym
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => scope})
      allow(controller).to receive(current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(current_user).and_return(user)
    end
  end


  def when_anonymous_user_redirect_to_new_user_session
    context "User is not logged in " do

      before :each do
        login_with nil
      end 

      it " redirects to login page" do 
        get :new
        expect( response ).to redirect_to( new_user_session_path )
        
      end
    end
  end
  
end
