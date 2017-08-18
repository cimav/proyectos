require 'test_helper'

class ProjectFoldersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_folder = project_folders(:one)
  end

  test "should get index" do
    get project_folders_url
    assert_response :success
  end

  test "should get new" do
    get new_project_folder_url
    assert_response :success
  end

  test "should create project_folder" do
    assert_difference('ProjectFolder.count') do
      post project_folders_url, params: { project_folder: { description: @project_folder.description, folder_type: @project_folder.folder_type, name: @project_folder.name, user_id: @project_folder.user_id } }
    end

    assert_redirected_to project_folder_url(ProjectFolder.last)
  end

  test "should show project_folder" do
    get project_folder_url(@project_folder)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_folder_url(@project_folder)
    assert_response :success
  end

  test "should update project_folder" do
    patch project_folder_url(@project_folder), params: { project_folder: { description: @project_folder.description, folder_type: @project_folder.folder_type, name: @project_folder.name, user_id: @project_folder.user_id } }
    assert_redirected_to project_folder_url(@project_folder)
  end

  test "should destroy project_folder" do
    assert_difference('ProjectFolder.count', -1) do
      delete project_folder_url(@project_folder)
    end

    assert_redirected_to project_folders_url
  end
end
