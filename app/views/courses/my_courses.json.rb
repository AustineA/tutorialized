@orders.map do | order |
  {
    title: order.course.title,
    paid: order.course.price.positive?,
    lesson: "#{order.course.lessons_count} Lessons",
    image: order.course.cover.url,
    url: "/courses/#{order.course.slug}"
  }
end