recommendation
============

Try to build a recommendation system for Synced website.

---

#### First version

First version is to realize a basic Item-Based Recommendation Engine to recommend several articles, which would be interested by an active user.

#### Usecase

+ __"Users that viewed this article also viewed..."__ from `user_id--viewed-->article_id` pairs


#### Usage

input_data should look like this:

```
[
{ user1_id: article1_id },
{ user2_id: article3_id },
{ user1_id: article3_id },
...
]
```

output should be like this:

```
article1_id: [article3_id, article_6_id, ...]
```

#### Development

Use redis to store the similarity matrix.

```
$ redis cli
> HGET "recommendation:similarity" article_id
> KEYS recommendation*
```

redis_keys 
recommendation:similarity => 存储了所有文章的相似度
recommendation:items      => 存储了所有的文章阅读数量
recommendation:item_pairs => 存储了每一对文章被同一个用户阅读过的数量


Sources / References
--------------------

[1] George Karypis (2000) Evaluation of Item-Based Top-N Recommendation Algorithms (University of Minnesota, Department of Computer Science / Army HPC Research Center)
