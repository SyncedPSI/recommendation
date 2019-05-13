recommendation
============

Try to build a recommendation system for Synced website.

---

#### First version

First version is to realize a basic Item-Based Recommendation Engine to recommend several articles, which would be interested by an active user.

#### Install
Add to Gemfile
```ruby
gem 'recommendation', github: 'SyncedPSI/recommendation'
```
Then execute:
```shell
$ bundle
```

#### Redis Configuration
add `config/initializers/recommendation.rb
```ruby
namespace = 'your:recommendation'
host = 'your_host'
redis_store = Redis.new(host: your_host, port: '6379', db: 5, namespace: 'recommendation')

Recommendation.configure do |config|
  config.redis = redis_store
end
```

#### Usecase

+ __"Users that viewed this article also viewed..."__ from `user_id--viewed-->article_id` pairs


#### Usage

input_data should look like this:

```ruby
{
  user1_id: [article1_id, article3_id, article5_id],
  user2_id: [article3_id, article4_id, article5_id],
  ...
}
```

output should be like this:

```
article1_id: [article3_id, article4_id, ...]
```

#### Development

Use redis to store the similarity matrix.

```shell
$ redis cli
> select 5 # select <db number>
> keys * 
> HGET "recommendation:similarity" article_id
> KEYS recommendation*
```

redis_keys 
1. recommendation:similarity => 存储了所有文章的相似度
2. recommendation:items      => 存储了所有的文章阅读数量
3. recommendation:item_pairs => 存储了每一对文章被同一个用户阅读过的数量


Sources / References
--------------------

[1] George Karypis (2000) Evaluation of Item-Based Top-N Recommendation Algorithms (University of Minnesota, Department of Computer Science / Army HPC Research Center)
