package com.example.restAPI.userData;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.convert.MappingMongoConverter;
import org.springframework.data.mongodb.core.convert.MongoCustomConversions;
import org.springframework.data.mongodb.core.convert.DefaultMongoTypeMapper;
import org.springframework.data.mongodb.core.convert.MongoTypeMapper;
import org.springframework.data.mongodb.core.mapping.MongoMappingContext;
import org.springframework.data.mongodb.MongoDatabaseFactory;

// The "_class" field being added to the MongoDB documents is a result of Spring Data MongoDB automatically storing
// the class name of the entity (User class) for inheritance purposes.
// This is done by default when using polymorphism in MongoDB to identify the type of object when reading the document back.
// So in order to remove it, this class is needed.

@Configuration
public class MongoConfig {

    @Bean
    public MappingMongoConverter mappingMongoConverter(MongoDatabaseFactory mongoDatabaseFactory,
                                                       MongoMappingContext mongoMappingContext,
                                                       MongoCustomConversions conversions) {

        MappingMongoConverter converter = new MappingMongoConverter(mongoDatabaseFactory, mongoMappingContext);

        converter.setCustomConversions(conversions);  // Set the custom conversions
        converter.setTypeMapper(defaultMongoTypeMapper());  // Remove the "_class" field
        return converter;
    }

    @Bean
    public MongoTypeMapper defaultMongoTypeMapper() {
        // Passing null to DefaultMongoTypeMapper removes the "_class" field
        return new DefaultMongoTypeMapper(null);
    }
}