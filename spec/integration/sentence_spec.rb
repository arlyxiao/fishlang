require 'spec_helper'

describe "Sentence check" do
	def login(user)
	  post_via_redirect user_session_path, 
		  'user[email]' => user.email, 
		  'user[password]' => user.password
	end

  before {
    @user = FactoryGirl.create :user
    login(@user)

    @lesson = FactoryGirl.create :lesson
    @practice_1 = FactoryGirl.create :practice, :lesson => @lesson
    @practice_2 = FactoryGirl.create :practice, :lesson => @lesson

    10.times do |i|
      s = FactoryGirl.create(:sentence, :practice => @practice_1)

      t = FactoryGirl.create(:sentence_translation, :sentence => s, :subject => 'test')
    end
  }

  describe "go into practice" do
  	before {
  		get "/practices/#{@practice_1.id}"
  		@user_exercise = assigns(:user_exercise)
  		@sentence_ids = assigns(:sentence_ids)
  	}

  	it "session" do
  		session[:practice_id].should == @practice_1.id
  	end

  	describe "sentence_ids" do
  		it "count" do
  			@sentence_ids.count.should == 10
  		end

  		it "type" do
  			@sentence_ids.class.should == [].class
  		end
  	end

  	describe "user_exercise" do
  		it "error_count" do
  			@user_exercise.error_count.should == 0
  		end

  		it "done_count" do
  			@user_exercise.done_count.should == 0
  		end

  	end


  	describe "go into check with first id" do
  		before {
  			id = @sentence_ids[0]
  			get "/practices/exam"
  			post "/sentences/#{id}/check", :subject => 'test'
  			@body = JSON::parse(response.body)
  		}

  		it "next_id" do
        @body['next_id'].should == @sentence_ids[1]
      end

      it "result" do
        @body['result'].should == true
      end

      it "done_count" do
        @body['done_count'].should == 1
      end

      it "error_count" do
        @body['error_count'].should == 0
      end

      it "current_type" do
        @body['current_type'].should == 'practice'
      end

  	end

  	describe "go into check with last id" do
  		before {
  			id = @sentence_ids[9]
  			get "/practices/exam"
  			post "/sentences/#{id}/check", :subject => 'test 111'
  			@body = JSON::parse(response.body)
  		}

  		it "next_id" do
        @body['next_id'].should == nil
      end

      it "result" do
        @body['result'].should == false
      end

      it "done_count" do
        @body['done_count'].should == 1
      end

      it "error_count" do
        @body['error_count'].should == 1
      end

      it "current_type" do
        @body['current_type'].should == 'practice'
      end

  	end

  	describe "go into check with all of id, incorrect answers" do
  		before {
  			@sentence_ids.each do |id|
  				get "/practices/exam"
	  			post "/sentences/#{id}/check", :subject => 'test 111'
  			end
  			@body = JSON::parse(response.body)
  		}

  		it "next_id" do
        @body['next_id'].should == nil
      end

      it "result" do
        @body['result'].should == false
      end

      it "done_count" do
        @body['done_count'].should == 10
      end

      it "error_count" do
        @body['error_count'].should == 10
      end

      it "current_type" do
        @body['current_type'].should == 'practice'
      end




      describe "go into sentence_failures page" do
      	before {
      		get "/sentence_failures"
      		@sentence_failures = assigns(:sentence_failures).map {|f| f}
      	}

      	it "count" do
      		@sentence_failures.count.should == 10
      	end


      end

  	end

  	describe "go into check with all of id, correct answers" do
  		before {
  			@sentence_ids.each do |id|
  				get "/practices/exam"
	  			post "/sentences/#{id}/check", :subject => 'test'
  			end
  			@body = JSON::parse(response.body)
  		}

  		it "next_id" do
        @body['next_id'].should == nil
      end

      it "result" do
        @body['result'].should == true
      end

      it "done_count" do
        @body['done_count'].should == 10
      end

      it "error_count" do
        @body['error_count'].should == 0
      end

      it "current_type" do
        @body['current_type'].should == 'practice'
      end

      it "points" do
      	@user.reload
      	@user.points.should == 10
      end

      describe "go into sentence_failures page" do
      	before {
      		get "/sentence_failures"
      		@sentence_failures = assigns(:sentence_failures).map {|f| f}
      	}

      	it "count" do
      		@sentence_failures.count.should == 0
      	end


      end

  	end

  end

  describe "go into lesson" do
  	before {
  		get "/lessons/#{@lesson.id}"
  		@user_exercise = assigns(:user_exercise)
  		@sentence_ids = assigns(:sentence_ids)
  	}

  	it "session" do
  		session[:lesson_id].should == @lesson.id
  	end

  	describe "sentence_ids" do
  		it "count" do
  			@sentence_ids.count.should == 10
  		end

  		it "type" do
  			@sentence_ids.class.should == [].class
  		end
  	end

  	describe "user_exercise" do
  		it "error_count" do
  			@user_exercise.error_count.should == 0
  		end

  		it "done_count" do
  			@user_exercise.done_count.should == 0
  		end

  	end


  	describe "go into check with first id" do
  		before {
  			id = @sentence_ids[0]
  			get "/lessons/exam"
  			post "/sentences/#{id}/check", :subject => 'test'
  			@body = JSON::parse(response.body)
  		}

  		it "next_id" do
        @body['next_id'].should == @sentence_ids[1]
      end

      it "result" do
        @body['result'].should == true
      end

      it "done_count" do
        @body['done_count'].should == 1
      end

      it "error_count" do
        @body['error_count'].should == 0
      end

      it "current_type" do
        @body['current_type'].should == 'lesson'
      end

  	end

  	describe "go into check with last id" do
  		before {
  			id = @sentence_ids[9]
  			get "/lessons/exam"
  			post "/sentences/#{id}/check", :subject => 'test 111'
  			@body = JSON::parse(response.body)
  		}

  		it "next_id" do
        @body['next_id'].should == nil
      end

      it "result" do
        @body['result'].should == false
      end

      it "done_count" do
        @body['done_count'].should == 1
      end

      it "error_count" do
        @body['error_count'].should == 1
      end

      it "current_type" do
        @body['current_type'].should == 'lesson'
      end

  	end

  	describe "go into check with all of id, incorrect answers" do
  		before {
  			@sentence_ids.each do |id|
  				get "/lessons/exam"
	  			post "/sentences/#{id}/check", :subject => 'test 111'
  			end
  			@body = JSON::parse(response.body)
  		}

  		it "next_id" do
        @body['next_id'].should == nil
      end

      it "result" do
        @body['result'].should == false
      end

      it "done_count" do
        @body['done_count'].should == 10
      end

      it "error_count" do
        @body['error_count'].should == 10
      end

      it "current_type" do
        @body['current_type'].should == 'lesson'
      end




      describe "go into sentence_failures page" do
      	before {
      		get "/sentence_failures"
      		@user_exercise = assigns(:user_exercise)
  				@sentence_ids = assigns(:sentence_ids)
      		@sentence_failures = assigns(:sentence_failures).map {|f| f}
      	}

      	it "count" do
      		@sentence_failures.count.should == 10
      	end

      	describe "user_exercise" do
		  		it "error_count" do
		  			@user_exercise.error_count.should == 0
		  		end

		  		it "done_count" do
		  			@user_exercise.done_count.should == 0
		  		end

		  	end


      	describe "go into check page" do

      		describe "go into check with all of id, incorrect answers" do
      			before {
			  			@sentence_ids.each do |id|
			  				get "/sentence_failures/exam"
				  			post "/sentences/#{id}/check", :subject => 'test 111'
			  			end
			  			@body = JSON::parse(response.body)
			  		}

			  		it "next_id" do
			        @body['next_id'].should == nil
			      end

			      it "result" do
			        @body['result'].should == false
			      end

			      it "done_count" do
			        @body['done_count'].should == 10
			      end

			      it "error_count" do
			        @body['error_count'].should == 10
			      end

			      it "current_type" do
			        @body['current_type'].should == 'sentence_failure'
			      end

			      describe "go into sentence_failures page" do
			      	before {
			      		get "/sentence_failures"
			      		@sentence_failures = assigns(:sentence_failures).map {|f| f}
			      	}

			      	it "total" do
			      		@sentence_failures.count.should == 10
			      	end

			      	it "each count" do
			      		@sentence_failures.each do |f|
			      			f.count.should == 2
			      		end
			      	end
			      end

      		end

      		describe "go into check with all of id, correct answers" do
      			before {
			  			@sentence_ids.each do |id|
			  				get "/sentence_failures/exam"
				  			post "/sentences/#{id}/check", :subject => 'test'
			  			end
			  			@body = JSON::parse(response.body)
			  		}

			  		it "next_id" do
			        @body['next_id'].should == nil
			      end

			      it "result" do
			        @body['result'].should == true
			      end

			      it "done_count" do
			        @body['done_count'].should == 10
			      end

			      it "error_count" do
			        @body['error_count'].should == 0
			      end

			      it "current_type" do
			        @body['current_type'].should == 'sentence_failure'
			      end

			      describe "go into sentence_failures page" do
			      	before {
			      		get "/sentence_failures"
			      		@sentence_failures = assigns(:sentence_failures).map {|f| f}
			      	}

			      	it "total" do
			      		@sentence_failures.count.should == 10
			      	end

			      	it "each error count" do
			      		@sentence_failures.each do |f|
			      			f.count.should == 1
			      		end
			      	end

			      	it "each correct count" do
			      		@sentence_failures.each do |f|
			      			f.correct_count.should == 1
			      		end
			      	end

			      	it "points" do
			      		@user.reload
			      		@user.points.should == 10
			      	end

			      end

      		end

      		describe "go into check with all of id, mixed answers, one incorrect" do
      			before {
      				(0..8).each do |i|
      					id = @sentence_ids[i]
      					get "/sentence_failures/exam"
				  			post "/sentences/#{id}/check", :subject => 'test'
      				end

      				id = @sentence_ids[9]
    					get "/sentence_failures/exam"
			  			post "/sentences/#{id}/check", :subject => 'test 111'
			  			@body = JSON::parse(response.body)
			  		}

			  		it "next_id" do
			        @body['next_id'].should == nil
			      end

			      it "result" do
			        @body['result'].should == false
			      end

			      it "done_count" do
			        @body['done_count'].should == 10
			      end

			      it "error_count" do
			        @body['error_count'].should == 1
			      end

			      it "current_type" do
			        @body['current_type'].should == 'sentence_failure'
			      end

			      describe "go into sentence_failures page" do
			      	before {
			      		get "/sentence_failures"
			      		@sentence_failures = assigns(:sentence_failures).map {|f| f}
			      	}

			      	it "total" do
			      		@sentence_failures.count.should == 10
			      	end


			      	it "points" do
			      		@user.reload
			      		@user.points.should == 1
			      	end

			      end

      		end

      	end


      end

  	end



  	describe "go into check with all of id, correct answers" do
  		before {
  			@sentence_ids.each do |id|
  				get "/lessons/exam"
	  			post "/sentences/#{id}/check", :subject => 'test'
  			end
  			@body = JSON::parse(response.body)
  		}

  		it "next_id" do
        @body['next_id'].should == nil
      end

      it "result" do
        @body['result'].should == true
      end

      it "done_count" do
        @body['done_count'].should == 10
      end

      it "error_count" do
        @body['error_count'].should == 0
      end

      it "current_type" do
        @body['current_type'].should == 'lesson'
      end

      it "points" do
      	@user.reload
      	@user.points.should == 10
      end


      describe "go into sentence_failures page" do
      	before {
      		get "/sentence_failures"
      		@sentence_failures = assigns(:sentence_failures).map {|f| f}
      	}

      	it "count" do
      		@sentence_failures.count.should == 0
      	end




      end

  	end

  end


end
