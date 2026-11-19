package com.florei.api.repo;

import org.springframework.data.repository.CrudRepository;

import com.florei.api.model.Persona;

public interface PersonaRepository extends CrudRepository<Persona, Long> {

}
