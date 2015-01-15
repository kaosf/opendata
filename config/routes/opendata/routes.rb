SS::Application.routes.draw do

  Opendata::Initializer

  concern :deletion do
    get :delete, on: :member
  end

  content "opendata" do
    get "/" => "main#index", as: :main
    resources :licenses, concerns: :deletion
    resources :dataset_categories, concerns: :deletion
    resources :dataset_groups, concerns: :deletion do
      get "search" => "dataset_groups/search#index", on: :collection
    end
    resources :datasets, concerns: :deletion do
      resources :resources, concerns: :deletion do
        get "file" => "resources#download"
        get "tsv" => "resources#download_tsv"
        get "content" => "resources#content"
      end
    end

    resources :idea_categories, concerns: :deletion
#    resources :idea_groups, concerns: :deletion do
#      get "search" => "idea_groups/search#index", on: :collection
#    end
#    resources :ideas, concerns: :deletion do
#      resources :resources, concerns: :deletion do
#        get "file" => "resources#download"
#        get "tsv" => "resources#download_tsv"
#        get "content" => "resources#content"
#      end
#    end

    resources :search_datasets, concerns: :deletion
    resources :search_dataset_groups, concerns: :deletion
    resources :search_ideas, concerns: :deletion
    resources :sparqls, concerns: :deletion
    resources :apis, concerns: :deletion
    resources :mypages, concerns: :deletion
    resources :my_datasets, concerns: :deletion
    resources :my_ideas, concerns: :deletion
    resources :apps, concerns: :deletion
    resources :ideas, concerns: :deletion
  end

  node "opendata" do
    get "category/" => "public#index", cell: "nodes/category"
    get "area/" => "public#index", cell: "nodes/area"

    get "dataset_category/" => "public#nothing", cell: "nodes/dataset_category"
    get "dataset_category/:name/" => "public#index", cell: "nodes/dataset_category"
    get "dataset_category/:name/rss.xml" => "public#rss", cell: "nodes/dataset_category"
    get "dataset_category/:name/areas" => "public#index_areas", cell: "nodes/dataset_category"
    get "dataset_category/:name/tags" => "public#index_tags", cell: "nodes/dataset_category"
    get "dataset_category/:name/formats" => "public#index_formats", cell: "nodes/dataset_category"
    get "dataset_category/:name/licenses" => "public#index_licenses", cell: "nodes/dataset_category"

    get "dataset/(index.:format)" => "public#index", cell: "nodes/dataset"
    get "dataset/rss.xml" => "public#rss", cell: "nodes/dataset"
    get "dataset/areas" => "public#index_areas", cell: "nodes/dataset"
    get "dataset/tags" => "public#index_tags", cell: "nodes/dataset"
    get "dataset/formats" => "public#index_formats", cell: "nodes/dataset"
    get "dataset/licenses" => "public#index_licenses", cell: "nodes/dataset"
    get "dataset/:dataset/resource/:id/" => "public#index", cell: "nodes/resource"
    get "dataset/:dataset/resource/:id/content.html" => "public#content", cell: "nodes/resource", format: false
    get "dataset/:dataset/resource/:id/*filename" => "public#download", cell: "nodes/resource", format: false
    get "dataset/:dataset/point/show.:format" => "public#show_point", cell: "nodes/dataset", format: false
    get "dataset/:dataset/point/add.:format" => "public#add_point", cell: "nodes/dataset", format: false
    get "dataset/:dataset/point/members.html" => "public#point_members", cell: "nodes/dataset", format: false

    match "search_dataset_group/(index.:format)" => "public#index", cell: "nodes/search_dataset_group", via: [:get, :post]
    match "search_dataset/(index.:format)" => "public#index", cell: "nodes/search_dataset", via: [:get, :post]
    get "search_dataset/rss.xml" => "public#rss", cell: "nodes/search_dataset"

    get "app/(index.:format)" => "public#index", cell: "nodes/app"
    get "app/:id/(index.:format)" => "public#show", cell: "nodes/app"

    get "idea_category/" => "public#nothing", cell: "nodes/idea_category"
    get "idea_category/:name/" => "public#index", cell: "nodes/idea_category"
    get "idea_category/:name/areas" => "public#index_areas", cell: "nodes/idea_category"
    get "idea_category/:name/tags" => "public#index_tags", cell: "nodes/idea_category"
    get "idea_category/:name/formats" => "public#index_formats", cell: "nodes/idea_category"
    get "idea_category/:name/licenses" => "public#index_licenses", cell: "nodes/idea_category"

    get "idea/(index.:format)" => "public#index", cell: "nodes/idea"
    get "idea/rss.xml" => "public#rss", cell: "nodes/idea"
    get "idea/areas" => "public#index_areas", cell: "nodes/idea"
    get "idea/tags" => "public#index_tags", cell: "nodes/idea"
#    get "idea/formats" => "public#index_formats", cell: "nodes/idea"
#    get "idea/licenses" => "public#index_licenses", cell: "nodes/idea"
    get "idea/:idea/point/show.:format" => "public#show_point", cell: "nodes/idea", format: false
    get "idea/:idea/point/add.:format" => "public#add_point", cell: "nodes/idea", format: false
    get "idea/:idea/point/members.html" => "public#point_members", cell: "nodes/idea", format: false

    match "search_idea/(index.:format)" => "public#index", cell: "nodes/search_idea", via: [:get, :post]
    get "search_idea/rss.xml" => "public#rss", cell: "nodes/search_idea"

#    get "idea/(index.:format)" => "public#index", cell: "nodes/idea"
#    get "idea/:id/(index.:format)" => "public#show", cell: "nodes/idea"

    get "sparql/(*path)" => "public#index", cell: "nodes/sparql"
    post "sparql/(*path)" => "public#index", cell: "nodes/sparql"
    get "api/package_list" => "public#package_list", cell: "nodes/api"
    get "api/group_list" => "public#group_list", cell: "nodes/api"
    get "api/tag_list" => "public#tag_list", cell: "nodes/api"
    get "api/package_show" => "public#package_show", cell: "nodes/api"
    get "api/tag_show" => "public#tag_show", cell: "nodes/api"
    get "api/group_show" => "public#group_show", cell: "nodes/api"
    get "api/1/package_list" => "public#package_list", cell: "nodes/api"
    get "api/1/group_list" => "public#group_list", cell: "nodes/api"
    get "api/1/tag_list" => "public#tag_list", cell: "nodes/api"
    get "api/1/package_show" => "public#package_show", cell: "nodes/api"
    get "api/1/tag_show" => "public#tag_show", cell: "nodes/api"
    get "api/1/group_show" => "public#group_show", cell: "nodes/api"

    get "member/:member" => "public#index", cell: "nodes/member"
    get "member/:member/datasets/(:filename.:format)" => "public#datasets", cell: "nodes/member"
    get "member/:member/ideas/(:filename.:format)" => "public#ideas", cell: "nodes/member"

    get "mypage/(index.html)" => "public#index", cell: "nodes/mypage"
    get "mypage/login"  => "public#login", cell: "nodes/mypage"
    post "mypage/login" => "public#login", cell: "nodes/mypage"
    get "mypage/logout" => "public#logout", cell: "nodes/mypage"
    get "mypage/:provider" => "public#provide", cell: "nodes/mypage"

    resource :profile, path: "my_profile", controller: "public", cell: "nodes/my_profile", concerns: :deletion
    resources :datasets, path: "my_dataset", controller: "public", cell: "nodes/my_dataset", concerns: :deletion do
      resources :resources, controller: "public", cell: "nodes/my_dataset/resources", concerns: :deletion do
        get "file" => "public#download"
        get "tsv" => "public#download_tsv"
      end
    end
    resources :apps, path: "my_app", controller: "public", cell: "nodes/my_app", concerns: :deletion
    resources :ideas, path: "my_idea", controller: "public", cell: "nodes/my_idea", concerns: :deletion
  end

  part "opendata" do
    get "mypage_login" => "public#index", cell: "parts/mypage_login"
    get "dataset" => "public#index", cell: "parts/dataset"
    get "dataset_group" => "public#index", cell: "parts/dataset_group"

    get "app" => "public#index", cell: "parts/app"
    get "idea" => "public#index", cell: "parts/idea"
  end

  page "opendata" do
    get "dataset/:filename.:format" => "public#index", cell: "pages/dataset"
  end
end
