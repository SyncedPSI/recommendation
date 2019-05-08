require 'spec_helper'

RSpec.describe Recommendation::SimilarityMatrix, 'similarity_matrix' do
  before(:each) do
    initialize_redis!
    @matrix = Recommendation::SimilarityMatrix.new(redis_prefix: 'recommendation_test', action: 'similarity')
  end

  it 'should have correct redis_key to save similarity_matrix' do
    expect(@matrix.redis_key).to eq('recommendation_test:similarity')
  end

  it 'should have default max_neighbors' do
    expect(@matrix.max_neighbors).to eq(50)
  end

  it 'should store an item similarities' do
    @matrix.update('item_foo', [['item_bar', 0.7], ['item_fnord', 0.3]])
    expect(@matrix.write_queue['item_foo'].length).to eq(2)
  end

  it 'should store member similarities uniquely' do
    @matrix.update('item_fnord', [['item_bar', 0.7], ['item_bar', 0.3]])
    expect(@matrix.write_queue['item_fnord'].length).to eq(1)
  end

  it 'should store member similarities uniquely and sum the scores' do
    @matrix.update('item_fnord', [['item_bar', 0.7], ['item_bar', 0.3]])
    expect(@matrix.write_queue['item_fnord']).to eq('item_bar' => 1.0)
  end

  it 'should write the n-most similar members and scores to redis on commit_item!' do
    @matrix.update('item_fnord', [['item_fnord', 0.3], ['item_bar', 0.3], ['item_foo', 0.75]])
    @matrix.update('item_fnord', [['item_bar', 0.7], ['item_bar', 0.3]])
    @matrix.commit_item!('item_fnord')
    expect(Recommendation.redis.hget('recommendation_test:similarity', 'item_fnord')).to eq('item_bar: 1.3|item_foo: 0.75|item_fnord: 0.3')
  end
end
