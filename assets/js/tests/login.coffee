describe "Login", ->
  before ->

  # ...
  # describe "#indexOf()", ->
  #   it "should return -1 when not present", ->
  #     expect([1, 2, 3].indexOf(4)).to.eql -1

  describe "login", ->
    it "should redirect to invalidlogin with invalid credentials", (done) ->
      $.ajax
        url: '/login'
        type: 'post'
        data: {username: 'fake', password: 'fake'}
        success: (data, status, xhr) ->
          expect(xhr.status).to.eql(200)

          domTest data, (dom, domDone) ->
            expect(dom.find('title').text()).to.eql 'Login Failed'
            domDone()
            done()

        error: (xhr, status, err) ->          
          expect().fail(err.toString())
          done()

    it "successful login should load home page", (done) ->
      

