class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :group_find

	def new
		if !current_user.is_member_of?(@group)
			flash[:warning] =  "你不是討論區成員，無法發文"
			redirect_to group_path(@group)
		end

		@post = @group.posts.new
	end

	def create
		@post = @group.posts.build(post_params)
		@post.author = current_user

		if @post.save
			flash[:warning] =  "新增文章成功"
			redirect_to group_path(@group)
		else
			flash[:warning] =  "Something wrong"
			render 'new'
		end

	end

	def edit
		@post = @group.posts.find(params[:id])

	end

	def update
		@post = @group.posts.find(params[:id])

		if @post.update(post_params)
			flash[:warning] =  "修改文章成功"
			redirect_to group_path(@group)
		else
			flash[:warning] =  "Something wrong"
			render 'edit'
		end


	end

	def destroy
		@post = @group.posts.find(params[:id])

		@post.destroy
		flash[:warning] =  "刪除文章"
		redirect_to group_path(@group)
	end

	private

	def post_params
		params.require(:post).permit(:content )
	end

	def group_find
		@group = Group.find(params[:group_id])
	end



end
