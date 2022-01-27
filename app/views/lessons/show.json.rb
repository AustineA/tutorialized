v = polymorphic_url(@lesson.video) if @lesson.video.attached?
lc = polymorphic_url(@lesson.cover.variant(Lesson.large_options)) if @lesson.cover.attached?
lt = polymorphic_url(@lesson.cover.variant(Lesson.thumbnail_options)) if @lesson.cover.attached?

lesson = {
  title: @lesson.title,
  video: v,
  cover: lc,
  thumbnail: lt,
  locked: false
}