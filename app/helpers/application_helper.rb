module ApplicationHelper

    def default_meta_tags
    {
      site: 'STAY with MU',
      title: 'STAY with MU',
      reverse: true,
      separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
      description: '曲を育てる、思い出記録サービス',
      keywords: 'Spotify,音楽, MU, シェア, 曲を育てる',   #キーワードを「,」区切りで設定する
      canonical: request.original_url,   #優先するurlを指定する
      icon: [                    #favicon、apple用アイコンを指定する
        { href: image_url('favicon.svg') },
      ],
      og: {
        site_name: 'STAY with MU',
        title: '曲を育てる、思い出記録サービス',
        description: '曲を育てる、思い出記録サービス', 
        type: 'website',
        url: request.original_url,
        image: image_url('logo_col.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        site: '@',
        image: image_url('logo_col.png')
      }
    }
  end
end
