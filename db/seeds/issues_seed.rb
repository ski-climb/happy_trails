class IssuesSeed
  def self.start
    issues_seed = IssuesSeed.new
    issues_seed.generate
  end

  def generate
    Issue.create!(
      user:         User.all.sample,
      title:        'Down Tree on Mesa Trail',
      description:  'Covering the entire trails. About 12-inch diameter.',
      category:     'obstacle',
      severity:     'low',
      latitude:     39.981358,
      longitude:    -105.284937
    )

    Issue.create!(
      user:         User.all.sample,
      title:        'Standing water near First Flatiron',
      description:  '10-foot stretch of 3-inch deep water. It has not rained recently.',
      category:     'mud',
      severity:     'medium',
      latitude:     39.990989,
      longitude:    -105.291461
    )

    Issue.create!(
      user:         User.all.sample,
      title:        'Peregrine nest near Royal Arch',
      description:  'Nest is near enough to the trail it should be closed immediately.',
      category:     'other',
      severity:     'high',
      latitude:     39.983567,
      longitude:    -105.291288
    )

    Issue.create!(
      user:         User.all.sample,
      title:        'Washout on Kohler Mesa Trail',
      description:  'Half the trail wiped out for 20 yard stretch.',
      category:     'washout',
      severity:     'medium',
      latitude:     39.988893,
      longitude:    -105.279013,
      resolved:     true
    )

    Issue.create!(
      user:         User.all.sample,
      title:        'Litter at Enchanted Mesa Trail Head',
      description:  'Trash and toilet paper abound.',
      category:     'other',
      severity:     'low',
      latitude:     39.992328,
      longitude:    -105.281564,
      resolved:     true
    )

    Issue.create!(
      user:         User.all.sample,
      title:        'Mud on Baseline Trail',
      description:  'Barely possible to walk without getting stuck.',
      category:     'mud',
      severity:     'medium',
      latitude:     39.999219,
      longitude:    -105.287902
    )

    Issue.create!(
      user:         User.all.sample,
      title:        'Downed Tree along Shanahan',
      description:  '16-inch diameter.',
      category:     'obstacle',
      severity:     'low',
      latitude:     39.964580,
      longitude:    -105.277050,
    )

    Issue.create!(
      user:         User.all.sample,
      title:        'Washout on Fern Canyon Trail',
      description:  'Lingering damage from Sept. 2013 flood.',
      category:     'washout',
      severity:     'low',
      latitude:     39.965496,
      longitude:    -105.291519,
    )

    Issue.create!(
      user:         User.all.sample,
      title:        'Landslide near Devils Thumb',
      description:  'Along trail in Shadow Canyon.',
      category:     'landslide',
      severity:     'low',
      latitude:     39.951805,
      longitude:    -105.293056,
    )

    Issue.create!(
      user:         User.all.sample,
      title:        'Copious mud along Homestead Trail',
      description:  'Entire quarter mile stretch of trail.',
      category:     'mud',
      severity:     'medium',
      latitude:     39.939460,
      longitude:    -105.266214,
    )
  end
end
