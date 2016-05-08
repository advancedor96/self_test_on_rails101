class GroupsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy]

	def join
		@group = Group.find(params[:id])

		if !current_user.is_member_of?(@group)
			current_user.join!(@group)
			flash[:warning] =  "加入討論區"
		else
			flash[:warning] =  "你已經在討論區裡"
		end

		redirect_to group_path(@group)

	end

	def quit
		@group = Group.find(params[:id])

		if current_user.is_member_of?(@group)
			current_user.quit!(@group)
			flash[:warning] =  "已退出討論區"
		else
			flash[:warning] =  "你本來就不在討論區裡了"
		end

		redirect_to group_path(@group)

	end


	def index
		@groups = Group.all
	end

	def new
		@group = Group.new
	end

	def show
		@group = Group.find(params[:id])
		@posts = @group.posts
	end

	def edit
		@group = current_user.groups.find(params[:id])
	end

	def update
		@group = current_user.groups.find(params[:id])

		if @group.update(groups_params)
			flash[:warning] =  "修改討論區成功"
			redirect_to groups_path
		else
			render 'edit'
		end
	end

	def create
		@group = current_user.groups.new(groups_params)

		if @group.save
			flash[:warning] =  "新增討論區成功"
			redirect_to groups_path
		else
			flash[:warning] =  "Something wrong"
			render 'new'
		end

	end

	def destroy
		@group = current_user.groups.find(params[:id])
		@group.destroy!
		flash[:info] =  "刪除了討論區"
		redirect_to groups_path

	end



	private

	def groups_params
		params.require(:group).permit(:title, :description)
	end


end
