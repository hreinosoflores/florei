package com.florei.api.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.florei.api.model.PersonaJuridica;
import com.florei.api.repo.PersonaJuridicaRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/personajuridica")
@CrossOrigin
public class PersonaJuridicaController {

	@Autowired
	private PersonaJuridicaRepository personaJuridicaRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, personaJuridicaRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody PersonaJuridica personaJuridica) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			personaJuridica.getAuditoria().setActivo(true);
			personaJuridica.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, personaJuridicaRepository.save(personaJuridica));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody PersonaJuridica personaJuridica) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			personaJuridica.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, personaJuridicaRepository.save(personaJuridica));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			personaJuridicaRepository.deleteById(id);
			Global.resultOK(result, id);
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PatchMapping("/activo/{usu}/{id}")
	public Map<String, Object> toggleActivo(@PathVariable Long usu, @PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			PersonaJuridica personaJuridica = personaJuridicaRepository.findById(id).orElse(null);
			if (personaJuridica != null) {
				personaJuridica.getAuditoria().setActivo(!personaJuridica.getAuditoria().getActivo());
				personaJuridica.getAuditoria().setFechaModificacion(new Date());
				personaJuridica.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, personaJuridicaRepository.save(personaJuridica));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
