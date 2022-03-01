# Set default properties that will be overwritten on a case by case basis
set_flextable_defaults(font.family = NULL,
                       font.size = 9,
                       v_align = "top",
                       fonts_ignore = TRUE)

# Create table
ft <- flextable(processedWorkBook[['ESS1']])

# Create header
ft <- delete_part(ft, "header")
ft <- add_header(ft,
                 V1 = "Earth Systems (ESS1)",
                 V2 = "Earth Systems (ESS1)",
                 V3 = "Earth Systems (ESS1)")
ft <- merge_h(ft, part = "header")
ft <- align(ft, 1, 1, align = "center", part = "header")
ft <- bold(ft, 1, 1, part = "header")
ft <- bg(ft, 1, 1, part = "header")

# Set outside borders
# ft <- border_outer(ft,
#                    border = fp_border_default(
#                      color = "black",
#                      style = "solid",
#                      width = 2
#                    ),
#                    part = "all")
#
# ft <-
#   border(
#     ft,
#     i = 1,
#     j = 1,
#     border = fp_border_default(
#       color = "black",
#       style = "solid",
#       width = 2
#     ),
#     part = "body"
#   )

# Now loop per asset and format
for (asset in assetsDefs$asset) {
  # Get asset defs
  asset_row   <- assetsDefs[assetsDefs$asset == asset, "asset_row"]
  asset_col   <- assetsDefs[assetsDefs$asset == asset, "asset_col"]
  merge_to    <- assetsDefs[assetsDefs$asset == asset, "merge_to"]
  asset_font  <- assetsDefs[assetsDefs$asset == asset, "asset_font"]
  font_size   <- assetsDefs[assetsDefs$asset == asset, "font_size"]
  is_bold     <- assetsDefs[assetsDefs$asset == asset, "is_bold"]
  is_italic   <- assetsDefs[assetsDefs$asset == asset, "is_italic"]
  font_color  <- assetsDefs[assetsDefs$asset == asset, "font_color"]
  bg_color    <- assetsDefs[assetsDefs$asset == asset, "bg_color"]
  v_align     <- assetsDefs[assetsDefs$asset == asset, "v_align"]
  h_align     <- assetsDefs[assetsDefs$asset == asset, "h_align"]
  hline_below <-
    assetsDefs[assetsDefs$asset == asset, "hline_below"]
  vline_left  <- assetsDefs[assetsDefs$asset == asset, "vline_left"]

  # Merge if necessary                                                      ####
  if (!is.na(merge_to)) {
    for (the_row in seq(from = asset_row,
                        to = nrow(ft$body$dataset),
                        by = 5)) {
      # Merge cells
      ft <- merge_at(ft, i = the_row, j = 1:merge_to)
    }
  }

  # Compose complex cell for "Clarification Statement"                      ####
  if (asset == "CS_statement") {
    for (the_row in seq(from = asset_row,
                        to = nrow(ft$body$dataset),
                        by = 5)) {
      ft <-  compose(
        ft,
        i = the_row,
        j = asset_col,
        value =  as_paragraph(
          as_chunk(
            "Clarification Statement: ",
            props = fp_text_default(
              color = "#af2513",
              bold = TRUE,
              font.size = font_size
            )
          ),
          as_i = V1
        )
      )
    }
  }

  # Compose complex cell for "Assessment Boundary"                          ####
  if (asset == "AB_statement") {
    for (the_row in seq(from = asset_row,
                        to = nrow(ft$body$dataset),
                        by = 5)) {
      ft <-  compose(
        ft,
        i = the_row,
        j = asset_col,
        value =  as_paragraph(
          as_chunk(
            "Assessment Boundary: ",
            props = fp_text_default(
              color = "#af2513",
              bold = TRUE,
              font.size = font_size
            )
          ),
          as_i = V1
        )
      )
    }
  }

  # Set font
  for (the_row in seq(from = asset_row,
                      to = nrow(ft$body$dataset),
                      by = 5)) {
    # Merge cells
    ft <-
      font(ft,
           i = the_row,
           j = asset_col,
           fontname = asset_font)
  }

  # Set font size
  for (the_row in seq(from = asset_row,
                      to = nrow(ft$body$dataset),
                      by = 5)) {
    # Merge cells
    ft <-
      fontsize(ft, i = the_row, j = asset_col, size = font_size)
  }

  # Set font color
  for (the_row in seq(from = asset_row,
                      to = nrow(ft$body$dataset),
                      by = 5)) {
    # Merge cells
    ft <- color(ft,
                i = the_row,
                j = asset_col,
                color = font_color)
  }

  # Set bold, if necessary
  if (is_bold) {
    for (the_row in seq(from = asset_row,
                        to = nrow(ft$body$dataset),
                        by = 5)) {
      # Merge cells
      ft <- bold(ft, i = the_row, j = asset_col)
    }
  }

  # Set italic, if necessary
  if (is_italic) {
    for (the_row in seq(from = asset_row,
                        to = nrow(ft$body$dataset),
                        by = 5)) {
      # Merge cells
      ft <- italic(ft, i = the_row, j = asset_col)
    }
  }

  # Set background color
  for (the_row in seq(from = asset_row,
                      to = nrow(ft$body$dataset),
                      by = 5)) {
    ft <- bg(ft, i = the_row, j = asset_col, bg = bg_color)
  }

  # Set vertical alignment
  for (the_row in seq(from = asset_row,
                      to = nrow(ft$body$dataset),
                      by = 5)) {
    ft <- valign(ft,
                 i = the_row,
                 j = asset_col,
                 valign = v_align)
  }

  # Set horizontal alignment
  for (the_row in seq(from = asset_row,
                      to = nrow(ft$body$dataset),
                      by = 5)) {
    ft <- align(ft,
                i = the_row,
                j = asset_col,
                align = h_align)
  }

  # Create horizontal lines
  if (hline_below) {
    for (the_row in seq(from = asset_row,
                        to = nrow(ft$body$dataset),
                        by = 5)) {
      # Merge cells
      ft <-
        hline(ft,
              i = the_row,
              border = officer::fp_border(width = 1))
    }
  }

  # Create vertical lines
  if (vline_left) {
    for (the_row in seq(from = asset_row,
                        to = nrow(ft$body$dataset),
                        by = 5)) {
      # Merge cells
      ft <-   vline(
        ft,
        i = the_row,
        j = asset_col,
        border = officer::fp_border(width = 1),
        part = 'body'
      )
    }
  }
}
# Set default properties that will be overwritten on a case by case basis
# set_flextable_defaults(font.family = NULL,
#                        font.size = 9,
#                        v_align = "top",
#                        fonts_ignore = TRUE)
# 
# # Create table
# ft <- flextable(processedWorkBook[['ESS1']])
# 
# # Create header
# ft <- delete_part(ft, "header")
# ft <- add_header(ft,
#                  V1 = "Earth Systems (ESS1)",
#                  V2 = "Earth Systems (ESS1)",
#                  V3 = "Earth Systems (ESS1)")
# ft <- merge_h(ft, part = "header")
# ft <- align(ft, 1, 1, align = "center", part = "header")
# ft <- bold(ft, 1, 1, part = "header")
# ft <- bg(ft, 1, 1, part = "header")
# 
# # Set outside borders
# # ft <- border_outer(ft,
# #                    border = fp_border_default(
# #                      color = "black",
# #                      style = "solid",
# #                      width = 2
# #                    ),
# #                    part = "all")
# #
# # ft <-
# #   border(
# #     ft,
# #     i = 1,
# #     j = 1,
# #     border = fp_border_default(
# #       color = "black",
# #       style = "solid",
# #       width = 2
# #     ),
# #     part = "body"
# #   )
# 
# # Now loop per asset and format
# for (asset in assetsDefs$asset) {
#   # Get asset defs
#   asset_row   <- assetsDefs[assetsDefs$asset == asset, "asset_row"]
#   asset_col   <- assetsDefs[assetsDefs$asset == asset, "asset_col"]
#   merge_to    <- assetsDefs[assetsDefs$asset == asset, "merge_to"]
#   asset_font  <- assetsDefs[assetsDefs$asset == asset, "asset_font"]
#   font_size   <- assetsDefs[assetsDefs$asset == asset, "font_size"]
#   is_bold     <- assetsDefs[assetsDefs$asset == asset, "is_bold"]
#   is_italic   <- assetsDefs[assetsDefs$asset == asset, "is_italic"]
#   font_color  <- assetsDefs[assetsDefs$asset == asset, "font_color"]
#   bg_color    <- assetsDefs[assetsDefs$asset == asset, "bg_color"]
#   v_align     <- assetsDefs[assetsDefs$asset == asset, "v_align"]
#   h_align     <- assetsDefs[assetsDefs$asset == asset, "h_align"]
#   hline_below <-
#     assetsDefs[assetsDefs$asset == asset, "hline_below"]
#   vline_left  <- assetsDefs[assetsDefs$asset == asset, "vline_left"]
# 
#   # Merge if necessary                                                      ####
#   if (!is.na(merge_to)) {
#     for (the_row in seq(from = asset_row,
#                         to = nrow(ft$body$dataset),
#                         by = 5)) {
#       # Merge cells
#       ft <- merge_at(ft, i = the_row, j = 1:merge_to)
#     }
#   }
# 
#   # Compose complex cell for "Clarification Statement"                      ####
#   if (asset == "CS_statement") {
#     for (the_row in seq(from = asset_row,
#                         to = nrow(ft$body$dataset),
#                         by = 5)) {
#       ft <-  compose(
#         ft,
#         i = the_row,
#         j = asset_col,
#         value =  as_paragraph(
#           as_chunk(
#             "Clarification Statement: ",
#             props = fp_text_default(
#               color = "#af2513",
#               bold = TRUE,
#               font.size = font_size
#             )
#           ),
#           as_i = V1
#         )
#       )
#     }
#   }
# 
#   # Compose complex cell for "Assessment Boundary"                          ####
#   if (asset == "AB_statement") {
#     for (the_row in seq(from = asset_row,
#                         to = nrow(ft$body$dataset),
#                         by = 5)) {
#       ft <-  compose(
#         ft,
#         i = the_row,
#         j = asset_col,
#         value =  as_paragraph(
#           as_chunk(
#             "Assessment Boundary: ",
#             props = fp_text_default(
#               color = "#af2513",
#               bold = TRUE,
#               font.size = font_size
#             )
#           ),
#           as_i = V1
#         )
#       )
#     }
#   }
# 
#   # Set font
#   for (the_row in seq(from = asset_row,
#                       to = nrow(ft$body$dataset),
#                       by = 5)) {
#     # Merge cells
#     ft <-
#       font(ft,
#            i = the_row,
#            j = asset_col,
#            fontname = asset_font)
#   }
# 
#   # Set font size
#   for (the_row in seq(from = asset_row,
#                       to = nrow(ft$body$dataset),
#                       by = 5)) {
#     # Merge cells
#     ft <-
#       fontsize(ft, i = the_row, j = asset_col, size = font_size)
#   }
# 
#   # Set font color
#   for (the_row in seq(from = asset_row,
#                       to = nrow(ft$body$dataset),
#                       by = 5)) {
#     # Merge cells
#     ft <- color(ft,
#                 i = the_row,
#                 j = asset_col,
#                 color = font_color)
#   }
# 
#   # Set bold, if necessary
#   if (is_bold) {
#     for (the_row in seq(from = asset_row,
#                         to = nrow(ft$body$dataset),
#                         by = 5)) {
#       # Merge cells
#       ft <- bold(ft, i = the_row, j = asset_col)
#     }
#   }
# 
#   # Set italic, if necessary
#   if (is_italic) {
#     for (the_row in seq(from = asset_row,
#                         to = nrow(ft$body$dataset),
#                         by = 5)) {
#       # Merge cells
#       ft <- italic(ft, i = the_row, j = asset_col)
#     }
#   }
# 
#   # Set background color
#   for (the_row in seq(from = asset_row,
#                       to = nrow(ft$body$dataset),
#                       by = 5)) {
#     ft <- bg(ft, i = the_row, j = asset_col, bg = bg_color)
#   }
# 
#   # Set vertical alignment
#   for (the_row in seq(from = asset_row,
#                       to = nrow(ft$body$dataset),
#                       by = 5)) {
#     ft <- valign(ft,
#                  i = the_row,
#                  j = asset_col,
#                  valign = v_align)
#   }
# 
#   # Set horizontal alignment
#   for (the_row in seq(from = asset_row,
#                       to = nrow(ft$body$dataset),
#                       by = 5)) {
#     ft <- align(ft,
#                 i = the_row,
#                 j = asset_col,
#                 align = h_align)
#   }
# 
#   # Create horizontal lines
#   if (hline_below) {
#     for (the_row in seq(from = asset_row,
#                         to = nrow(ft$body$dataset),
#                         by = 5)) {
#       # Merge cells
#       ft <-
#         hline(ft,
#               i = the_row,
#               border = officer::fp_border(width = 1))
#     }
#   }
# 
#   # Create vertical lines
#   if (vline_left) {
#     for (the_row in seq(from = asset_row,
#                         to = nrow(ft$body$dataset),
#                         by = 5)) {
#       # Merge cells
#       ft <-   vline(
#         ft,
#         i = the_row,
#         j = asset_col,
#         border = officer::fp_border(width = 1),
#         part = 'body'
#       )
#     }
#   }
# }
# # Set table width
#set_table_properties(ft, width = 1)
