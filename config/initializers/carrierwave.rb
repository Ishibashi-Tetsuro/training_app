require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      # アクセスキー
      aws_access_key_id:     'AKIAXJUA7RJRLBDYNT5I',
      # シークレットキー
      aws_secret_access_key: 'soLmW3y6JdJt3L6Eo3Ncppft6gje9wHs+UlVrgHA',
      # Tokyo
      region:                'ap-northeast-1',
    }

    # 公開・非公開の切り替え
    config.fog_public     = false
    # キャッシュの保存期間
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }

    # キャッシュをS3に保存
    # config.cache_storage = :fog

    # 環境ごとにS3のバケットを指定
    case Rails.env
      when 'production'
        config.fog_directory = 'home-gym-image-store'
        config.asset_host = 'https://home-gym-image-store.s3-ap-northeast-1.amazonaws.com'

      when 'development'
        config.fog_directory = 'dev-home-gym-image-store'
        config.asset_host = 'https://dev-home-gym-image-store.s3-ap-northeast-1.amazonaws.com'

      when 'test'
        config.fog_directory = 'dev-home-gym-image-store'
        config.asset_host = 'https://dev-home-gym-image-store.s3-ap-northeast-1.amazonaws.com'
    end
  end

# 日本語ファイル名の設定
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
