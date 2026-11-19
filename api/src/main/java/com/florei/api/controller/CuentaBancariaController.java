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

import com.florei.api.model.CuentaBancaria;
import com.florei.api.repo.CuentaBancariaRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/cuentabancaria")
@CrossOrigin
public class CuentaBancariaController {
	@Autowired
	private CuentaBancariaRepository cuentaBancariaRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, cuentaBancariaRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody CuentaBancaria cuentaBancaria) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cuentaBancaria.getAuditoria().setActivo(true);
			cuentaBancaria.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, cuentaBancariaRepository.save(cuentaBancaria));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody CuentaBancaria cuentaBancaria) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cuentaBancaria.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, cuentaBancariaRepository.save(cuentaBancaria));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cuentaBancariaRepository.deleteById(id);
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
			CuentaBancaria cuentaBancaria = cuentaBancariaRepository.findById(id).orElse(null);
			if (cuentaBancaria != null) {
				cuentaBancaria.getAuditoria().setActivo(!cuentaBancaria.getAuditoria().getActivo());
				cuentaBancaria.getAuditoria().setFechaModificacion(new Date());
				cuentaBancaria.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, cuentaBancariaRepository.save(cuentaBancaria));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
