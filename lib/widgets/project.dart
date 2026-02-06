class Project {
  final String city, title, imageUrl, unit;
  final String year;
  final String capacity;

  const Project({
    required this.city,
    required this.title,
    required this.imageUrl,
    required this.capacity,
    required this.unit,
    required this.year,
  });
}

const demoProjects = <Project>[
  Project(
    city: "Kastamon",
    title: "Solar Plant",
    capacity: "2.4",
    unit: "MW",
    year: "2022",
    imageUrl:
    "https://images.unsplash.com/photo-1508514177221-188b1cf16e9d?q=80&w=1600&auto=format&fit=crop",
  ),
  Project(
    city: "Bozüyük",
    title: "Agricultural Solar Installation",
    capacity: "1.2",
    unit: "MW",
    year: "2023",
    imageUrl:
    "https://images.unsplash.com/photo-1509395176047-4a66953fd231?q=80&w=1600&auto=format&fit=crop",
  ),
  Project(
    city: "İstanbul",
    title: "Solar Park",
    capacity: "1.8",
    unit: "MW",
    year: "2021",
    imageUrl:
    "https://images.unsplash.com/photo-1506462945848-ac8ea6f609cc?q=80&w=1600&auto=format&fit=crop",
  ),
  Project(
    city: "Antalya",
    title: "OSB Rooftop",
    capacity: "3.1",
    unit: "MW",
    year: "2024",
    imageUrl:
    "https://images.unsplash.com/photo-1508514177221-188b1cf16e9d?q=80&w=1600&auto=format&fit=crop",
  ),
  Project(
    city: "Eskişehir",
    title: "Solar Field",
    capacity: "0.9",
    unit: "MW",
    year: "2020",
    imageUrl:
    "https://images.unsplash.com/photo-1545205597-3d9d02c29597?q=80&w=1600&auto=format&fit=crop",
  ),
];