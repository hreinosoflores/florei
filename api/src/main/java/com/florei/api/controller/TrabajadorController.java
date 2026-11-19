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

import com.florei.api.model.Trabajador;
import com.florei.api.repo.TrabajadorRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/trabajador")
@CrossOrigin
public class TrabajadorController {

	@Autowired
	private TrabajadorRepository trabajadorRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, trabajadorRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Trabajador trabajador) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			trabajador.getAuditoria().setActivo(true);
			trabajador.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, trabajadorRepository.save(trabajador));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Trabajador trabajador) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			trabajador.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, trabajadorRepository.save(trabajador));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			trabajadorRepository.deleteById(id);
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
			Trabajador trabajador = trabajadorRepository.findById(id).orElse(null);
			if (trabajador != null) {
				trabajador.getAuditoria().setActivo(!trabajador.getAuditoria().getActivo());
				trabajador.getAuditoria().setFechaModificacion(new Date());
				trabajador.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, trabajadorRepository.save(trabajador));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
