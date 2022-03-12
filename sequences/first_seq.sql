select golf_course.id,
       upper(golf_course.name),
       difficulty_level,
       dln.difficulty_name,
       round((length + 0.0) / 10) / 100 as length_km,
       holes,
       water_hazards,
       description,
       (person.name, person.surname, person.email) as person_who_registered,
       person_who_registered is not null as current_state
from golf_course inner join difficulty_level_name dln on dln.id = golf_course.id
                 left join person on person.id = golf_course.person_who_registered