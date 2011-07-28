Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'Om10xZqwFnWShJmQQejFg', 'wd0fMtA0HjLjyyC8jgjoqemNHVpZFm9uMBdZT3t8o'
  provider :facebook, '223312437712461', 'c1d7be7f56c673548b8af514ecc496be'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end