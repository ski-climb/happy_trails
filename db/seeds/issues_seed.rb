class IssuesSeed
  def self.start
    issues_seed = IssuesSeed.new
    issues_seed.generate
  end

  def generate
    issue_1 = Issue.create!(
      user:         User.all.sample,
      title:        'Downed Tree on Mesa Trail',
      description:  'Covering the entire trails. About 12-inch diameter.',
      category:     'obstacle',
      severity:     'low',
      latitude:     39.981358,
      longitude:    -105.284937
    )

    issue_1.photos.create!( user: issue_1.user,
                            url:  Rails.root.join('spec/fixtures/downed_tree.jpg').open
                          )

    issue_2 = Issue.create!(
      user:         User.all.sample,
      title:        'Standing water near First Flatiron',
      description:  '10-foot stretch of 3-inch deep water. It has not rained recently.',
      category:     'mud',
      severity:     'medium',
      latitude:     39.990989,
      longitude:    -105.291461
    )

    issue_2.photos.create!( user: issue_2.user,
                            url:  Rails.root.join('spec/fixtures/flooded_trail.jpg').open
                          )

    issue_3 = Issue.create!(
      user:         User.all.sample,
      title:        'Peregrine nest near Royal Arch',
      description:  'Nest is near enough to the trail it should be closed immediately.',
      category:     'other',
      severity:     'high',
      latitude:     39.983567,
      longitude:    -105.291288
    )

    issue_3.photos.create!( user: issue_3.user,
                            url:  Rails.root.join('spec/fixtures/peregrine.jpg').open
                          )

    issue_4 = Issue.create!(
      user:         User.all.sample,
      title:        'Washout on Kohler Mesa Trail',
      description:  'Bridge wiped out on trail wiped.',
      category:     'washout',
      severity:     'medium',
      latitude:     39.988893,
      longitude:    -105.279013,
      resolved:     true
    )

    issue_4.photos.create!( user: issue_4.user,
                            url:  Rails.root.join('spec/fixtures/bridge_damaged_on_trail.jpg').open
                          )

    issue_5 = Issue.create!(
      user:         User.all.sample,
      title:        'Downed Tree at Enchanted Mesa Trail Head',
      description:  'Difficult to step over.',
      category:     'obstacle',
      severity:     'low',
      latitude:     39.992328,
      longitude:    -105.281564,
      resolved:     true
    )

    issue_5.photos.create!( user: issue_5.user,
                            url:  Rails.root.join('spec/fixtures/downed_tree.jpg').open
                          )

    issue_6 = Issue.create!(
      user:         User.all.sample,
      title:        'Mud on Baseline Trail',
      description:  'Barely possible to walk without getting stuck.',
      category:     'mud',
      severity:     'medium',
      latitude:     39.999219,
      longitude:    -105.287902
    )

    issue_6.photos.create!( user: issue_6.user,
                            url:  Rails.root.join('spec/fixtures/flooded_trail.jpg').open
                          )

    issue_7 = Issue.create!(
      user:         User.all.sample,
      title:        'Downed Tree along Shanahan',
      description:  '16-inch diameter.',
      category:     'obstacle',
      severity:     'low',
      latitude:     39.964580,
      longitude:    -105.277050,
    )

    issue_7.photos.create!( user: issue_7.user,
                            url:  Rails.root.join('spec/fixtures/downed_tree.jpg').open
                          )

    issue_8 = Issue.create!(
      user:         User.all.sample,
      title:        'Bridge Damage on Fern Canyon Trail',
      description:  'Lingering damage from Sept. 2013 flood.',
      category:     'washout',
      severity:     'low',
      latitude:     39.965496,
      longitude:    -105.291519,
    )

    issue_8.photos.create!( user: issue_8.user,
                            url:  Rails.root.join('spec/fixtures/bridge_damaged_on_trail.jpg').open
                          )

    issue_9 = Issue.create!(
      user:         User.all.sample,
      title:        'Destroyed bridge near Devils Thumb',
      description:  'Along trail in Shadow Canyon.',
      category:     'landslide',
      severity:     'high',
      latitude:     39.951805,
      longitude:    -105.293056,
    )

    issue_9.photos.create!( user: issue_9.user,
                            url:  Rails.root.join('spec/fixtures/bridge_damaged_on_trail.jpg').open
                          )

    issue_10 = Issue.create!(
      user:         User.all.sample,
      title:        'Large rock along Homestead Trail',
      description:  'Enormous enormous rock.',
      category:     'obstacle',
      severity:     'medium',
      latitude:     39.939460,
      longitude:    -105.266214,
    )

    issue_10.photos.create!( user: issue_10.user,
                             url:  Rails.root.join('spec/fixtures/boulder_on_trail.jpg').open
                           )
  end
end
