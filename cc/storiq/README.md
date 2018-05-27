# Background

Retailers organise their business structure like a hierarchical tree, for example they could have many employees, in many shops, which could be part of an area, which could be part of a region, etc.

StorIQ lets business conduct different types of reviews against any part of that hierarchy. We then allow the business to view reports across the hierarchy.

# Expectation

Build the classes in ruby necessary to represent the expectations below.

It should allow the creation of entities in a hierarchy as described above (the entities are linked, in a tree).

It should allow reviews and scores to be created for these entities.

It should be possible to create unlimited levels of entities in the hierarchy (i.e. don't create individual classes for employees, shops, areas etc, create a single class for an entity)

It should be possible to get the average score for an entity, which is an average of it's own scores and the scores of it's linked entities in the hierarchy.

Here is list of expectations:

 - I can create many entities in the hierarchy
 - I can create a review for an entity
 - I can add many scores to a review (a score is a integer between 1 and 5)
 - I can view the average score for a particular entity
 - I can view the average score for a particular review of an entity
 - I can view the average scores for all entities
