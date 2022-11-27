using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace InventarioFarmaUziel.Models;

public partial class FarmaUzielContext : DbContext
{
    public FarmaUzielContext()
    {
    }

    public FarmaUzielContext(DbContextOptions<FarmaUzielContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Cliente> Clientes { get; set; }

    public virtual DbSet<Medicamento> Medicamentos { get; set; }

    public virtual DbSet<Venta> Ventas { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("server=JEFERSON-MAYORG\\SQLEXPRESS; Database=FarmaUZIEL; Trusted_Connection=True; Encrypt=False;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Cliente>(entity =>
        {
            entity.HasKey(e => e.IdCliente).HasName("PK__Clientes__3DD0A8CB1535D899");

            entity.Property(e => e.IdCliente).HasColumnName("Id_Cliente");
            entity.Property(e => e.DirC).HasMaxLength(70);
            entity.Property(e => e.Pacliente)
                .HasMaxLength(15)
                .HasColumnName("PACliente");
            entity.Property(e => e.Pncliente)
                .HasMaxLength(15)
                .HasColumnName("PNCliente");
            entity.Property(e => e.Sacliente)
                .HasMaxLength(15)
                .HasColumnName("SACliente");
            entity.Property(e => e.Sncliente)
                .HasMaxLength(15)
                .HasColumnName("SNCliente");
            entity.Property(e => e.TelCliente)
                .HasMaxLength(8)
                .IsUnicode(false)
                .IsFixedLength();
        });

        modelBuilder.Entity<Medicamento>(entity =>
        {
            entity.HasKey(e => e.IdMedicamento).HasName("PK__Medicame__AC96376ECD269E26");

            entity.Property(e => e.Cantidad).HasColumnName("cantidad");
            entity.Property(e => e.DescProd).HasMaxLength(50);
            entity.Property(e => e.Distribuidora).HasMaxLength(50);
            entity.Property(e => e.FechaElab).HasColumnType("datetime");
            entity.Property(e => e.FechaVenc).HasColumnType("datetime");
            entity.Property(e => e.NombreMed).HasMaxLength(50);
            entity.Property(e => e.Precio).HasColumnName("precio");
        });

        modelBuilder.Entity<Venta>(entity =>
        {
            entity.HasKey(e => e.IdVenta).HasName("PK__Ventas__B3C9EABDC846244A");

            entity.Property(e => e.IdVenta).HasColumnName("Id_Venta");
            entity.Property(e => e.Cantidadv).HasColumnName("cantidadv");
            entity.Property(e => e.FechaVenta)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("Fecha_Venta");
            entity.Property(e => e.IdCliente).HasColumnName("Id_Cliente");
            entity.Property(e => e.Subtotalv).HasColumnName("subtotalv");
            entity.Property(e => e.Totalv).HasColumnName("totalv");

            entity.HasOne(d => d.IdClienteNavigation).WithMany(p => p.Venta)
                .HasForeignKey(d => d.IdCliente)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Ventas__Id_Clien__49C3F6B7");

            entity.HasOne(d => d.IdMedicamentoNavigation).WithMany(p => p.Venta)
                .HasForeignKey(d => d.IdMedicamento)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Ventas__IdMedica__4AB81AF0");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
