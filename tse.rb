#!/usr/bin/env ruby

require 'rubygems'
require 'sequel'

module TSE
def self.run
    Sequel.connect('sqlite://padron.db') do |db|
        ds = db[:TBL_PADRON].
            join(:TBL_JUNTAS, :NUM_JUNTA => :NUM_JUNTA).
            join(:TBL_CODELE_COMPLETO,
                 :COD_PROVINCIA => :TBL_JUNTAS__COD_PROVINCIA,
                 :COD_CANTON    => :TBL_JUNTAS__COD_CANTON,
                 :COD_DIST_ELEC => :TBL_JUNTAS__COD_DIST_ELEC).
            join(:TBL_CENTROS_VOTACION,
                 :JUNTA => :TBL_JUNTAS__NUM_JUNTA).
            select(:nombre,
                   :pape,
                   :sape,
                   :cedula,
                   :ediv_nombre_provincia.as(:PROVINCIA),
                   :ediv_nombre_canton.as(:CANTON),
                   :ediv_nombre_dist_elec.as(:DISTRITO),
                   :tbl_padron__num_junta.as(:JUNTA),
                   :tbl_centros_votacion__descripcion.as(:LOC)
                  ).
            order(:cedula)

        yield ds
    end
end

def self.query(ds, line)
    search = deaccent(line.upcase)

    case search
    when /^(\d+)[- ]+(\d+)[- ]+(\d+)$/

        n = "%d%04d%04d" % Regexp.last_match[1..3].map { |v| v.to_i }

        return ds.where(:CEDULA => n), :cedula, "#{n}"

    when /^\d+$/

        return ds.where(:CEDULA => search), :cedula, search

    when /^([^,]+),\s+(\S+)$/,
         /^(\S+)\s+(\S+)$/

        nombre, pape = Regexp.last_match[1..2]

        q = find_by_name(ds, nombre, pape)
        if q.count == 0
            q = find_by_name(ds, "%#{nombre}%", pape)
            if q.count == 0
                q = find_by_name(ds, "%#{nombre}%", "#{pape}%")
                if q.count == 0
                    q = find_by_name(ds, "%#{nombre}%", "%#{pape}%")
                end
            end
        end

        return q, :nombre, "#{nombre} #{pape}"

    when /^([^,]+),\s+([^,]+),\s+(\S+)$/,
         /^([^,]+),\s+(\S+)\s+(\S+)$/,
         /^(\S+)\s+(\S+)\s+(\S+)$/

        nombre, pape, sape = Regexp.last_match[1..3]

        q = find_by_name(ds, nombre, pape, sape)
        if q.count == 0
            q = find_by_name(ds, "%#{nombre}%", pape, sape)
            if q.count == 0
                q = find_by_name(ds,
                                 "%#{nombre}%",
                                 "#{pape}%",
                                 "#{sape}%")
                if q.count == 0
                    q = find_by_name(ds,
                                     "%#{nombre}%",
                                     "%#{pape}%",
                                     "%#{sape}%")
                end
            end
        end

        return q, :nombre, "#{nombre} #{pape} #{sape}"

    when "Q", "QUIT", "EXIT", "SALIR"
        return :Q

    else
        return nil
    end
end

private
def self.deaccent(s)
    mapping = {
        'á' => 'A', 'é' => 'E', 'í' => 'I', 'ó' => 'O', 'ú' => 'U',
        'Á' => 'A', 'É' => 'E', 'Í' => 'I', 'Ó' => 'O', 'Ú' => 'U',
        'ü' => 'U', 'Ü' => 'U',
        'ñ' => 'Ñ',
        'ç' => 'C', 'Ç' => 'C',
    }

    n = s.clone

    mapping.each { |k, v| n.gsub!(k, v) }

    return n
end

def self.build_where(ds, sym, q)
    q.include?('%') ? ds.where(sym.like(q)) : ds.where(sym => q)
end

def self.find_by_name(ds, nombre, pape, sape=nil)
    ds = build_where(ds, :NOMBRE, nombre)
    ds = build_where(ds, :PAPE, pape)
    unless sape.nil?
        ds = build_where(ds, :SAPE, sape)
    end

    ds
end
end
