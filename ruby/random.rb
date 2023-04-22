# 6人のグループ
group = ["A", "B", "C", "D", "E", "F"]

group1 = []
group2 = []

# 2、4の場合：2人と4人に分ける or 3の場合：3人と3人に分ける
random_split = rand(2..4)

group1 = group.sample(random_split)
group2 = group - group1

p group1.sort
p group2.sort
