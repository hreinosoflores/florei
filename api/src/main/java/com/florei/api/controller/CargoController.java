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

import com.florei.api.model.Cargo;
import com.florei.api.repo.CargoRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/cargo")
@CrossOrigin
public class CargoController {
	@Autowired
	private CargoRepository cargoRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, cargoRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Cargo cargo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cargo.getAuditoria().setActivo(true);
			cargo.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, cargoRepository.save(cargo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Cargo cargo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cargo.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, cargoRepository.save(cargo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cargoRepository.deleteById(id);
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
			Cargo cargo = cargoRepository.findById(id).orElse(null);
			if (cargo != null) {
				cargo.getAuditoria().setActivo(!cargo.getAuditoria().getActivo());
				cargo.getAuditoria().setFechaModificacion(new Date());
				cargo.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, cargoRepository.save(cargo));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
